/* mymidikbd.c
 * a basic virtual midi keyboard, for use with timidity, ALSA,
 * and lilypond-quick-insert emacs mode.
 *
 * Nicolas Sceaux <nicolas.sceaux@free.fr>
 * 2003/03/08
 *
 * Mainly inspired by Virtual Tiny Keyboard, by Takashi Iwai
 * http://www.alsa-project.org/~iwai/alsa.html#vkeybd
 * in particular: oper_alsa.c
 */

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <alsa/asoundlib.h>

#define DEFAULT_NAME  "mymidikbd"

static snd_seq_t *seq_handle = NULL;
static int my_client, my_port;
static int seq_client = 128;
static int seq_port = 0;
static int chan_no = 0;
static snd_seq_event_t ev;
static int seq_opened;

int seq_open() {
  unsigned int caps;
  if (!seq_opened) {
    /* sequencer opening */
    if (snd_seq_open(&seq_handle, "hw", SND_SEQ_OPEN_OUTPUT, 0)) {
      fprintf(stderr, "Error opening ALSA sequencer.\n");
      return(-1);
    }
    /* our client id */
    my_client = snd_seq_client_id(seq_handle);
    /* set client info */
    snd_seq_set_client_name(seq_handle, DEFAULT_NAME);
    /* create port */
    caps = SND_SEQ_PORT_CAP_READ;
    if (seq_client == SND_SEQ_ADDRESS_SUBSCRIBERS)
      caps |= SND_SEQ_PORT_CAP_SUBS_READ;
    my_port = snd_seq_create_simple_port(seq_handle, DEFAULT_NAME, caps,SND_SEQ_PORT_TYPE_MIDI_GENERIC | SND_SEQ_PORT_TYPE_APPLICATION);
    if (my_port < 0) {
      fprintf(stderr, "can't create port\n");
      snd_seq_close(seq_handle);
      return 0;
    }
    /* subscribe to MIDI port */
    if (seq_client != SND_SEQ_ADDRESS_SUBSCRIBERS) {
      if (snd_seq_connect_to(seq_handle, my_port, seq_client, seq_port) < 0) {
        fprintf(stderr, "can't subscribe to MIDI port (%d:%d)\n", seq_client, seq_port);
        snd_seq_close(seq_handle);
        return 0;
      }
    }
  }
  seq_opened = 1;
  return 1;
}

void seq_close() {
  if (seq_opened)
    snd_seq_close(seq_handle);
  seq_opened = 0;
}

void send_event() {
  snd_seq_ev_set_direct(&ev);
  snd_seq_ev_set_source(&ev, my_port);
  snd_seq_ev_set_dest(&ev, seq_client, seq_port);
  snd_seq_event_output(seq_handle, &ev);
  snd_seq_drain_output(seq_handle);
}

void note_on(int note, int vel) {
  snd_seq_ev_set_noteon(&ev, chan_no, note, vel);
  send_event();
}

void note_off(int note, int vel) {
  snd_seq_ev_set_noteoff(&ev, chan_no, note, vel);
  send_event();
}

void play_note(int pitch, float length) {
  note_on (pitch, 100);
  usleep((int) (length * 1000000));
  note_off(pitch, 100);
}

void play_rest(float length) {
  usleep((int) (length * 1000000));
}

int main (int argc, char** argv) {
  int pitch;
  float length;
  char buf[16];
  seq_opened = 0;
  if (argc > 1) seq_client = atoi(argv[1]);
  seq_open();
  while (fgets(buf, 16, stdin) != NULL) {
    if (sscanf (buf, "%d %f", &pitch, &length)) {
      /* a single short note */
      if (length <= 0) {
        if ((pitch > 0) && (pitch == (pitch % 128))) {
          //seq_open();
          play_note (pitch, 0.1);
          //seq_close();
        }
      }
      else {
        //seq_open();
        if ((pitch > 0) && (pitch == (pitch % 128)))
          play_note (pitch, length);
        else
          play_rest (length);
      }
    }
  }
  seq_close();
  return 0;
}
