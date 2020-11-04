//  Some strings just are mute or repetetive. The order is as given in the ToneGenerator Class
//  https://developer.android.com/reference/android/media/ToneGenerator

import android.media.ToneGenerator;
import android.media.AudioManager;

String[] tones = {"TONE_CDMA_ABBR_ALERT", "TONE_CDMA_ABBR_INTERCEPT", "TONE_CDMA_ABBR_REORDER", "TONE_CDMA_ALERT_AUTOREDIAL_LITE", "TONE_CDMA_ALERT_CALL_GUARD", "TONE_CDMA_ALERT_INCALL_LITE", 
  "TONE_CDMA_ALERT_NETWORK_LITE", "TONE_CDMA_ANSWER", "TONE_CDMA_CALLDROP_LITE", "TONE_CDMA_CALL_SIGNAL_ISDN_INTERGROUP", "TONE_CDMA_CALL_SIGNAL_ISDN_NORMAL", 
  "TONE_CDMA_CALL_SIGNAL_ISDN_PAT3", "TONE_CDMA_CALL_SIGNAL_ISDN_PAT5", "TONE_CDMA_CALL_SIGNAL_ISDN_PAT6", "TONE_CDMA_CALL_SIGNAL_ISDN_PAT7", "TONE_CDMA_CALL_SIGNAL_ISDN_PING_RING", 
  "TONE_CDMA_CALL_SIGNAL_ISDN_SP_PRI", "TONE_CDMA_CONFIRM", "TONE_CDMA_DIAL_TONE_LITE", "TONE_CDMA_EMERGENCY_RINGBACK", "TONE_CDMA_HIGH_L", "TONE_CDMA_HIGH_PBX_L", 
  "HIGH PBX L", "TONE_CDMA_HIGH_PBX_SLS", "TONE_CDMA_HIGH_PBX_SS", "TONE_CDMA_HIGH_PBX_SSL", "TONE_CDMA_HIGH_PBX_S_X4", "TONE_CDMA_HIGH_SLS", "TONE_CDMA_HIGH_SS", "TONE_CDMA_HIGH_SSL", 
  "TONE_CDMA_HIGH_SS_2", "TONE_CDMA_HIGH_S_X4", "TONE_CDMA_INTERCEPT", "TONE_CDMA_KEYPAD_VOLUME_KEY_LITE", "TONE_CDMA_LOW_L", "TONE_CDMA_LOW_PBX_L", 
  "TONE_CDMA_LOW_PBX_SLS", "TONE_CDMA_LOW_PBX_SS", "TONE_CDMA_LOW_PBX_SSL", "TONE_CDMA_LOW_PBX_S_X4", "TONE_CDMA_LOW_SLS", "TONE_CDMA_LOW_SS", "TONE_CDMA_LOW_SSL", "TONE_CDMA_LOW_SS_2", 
  "TONE_CDMA_LOW_S_X4", "TONE_CDMA_MED_L", "TONE_CDMA_MED_PBX_L", "TONE_CDMA_MED_PBX_SLS", "TONE_CDMA_MED_PBX_SS", "TONE_CDMA_MED_PBX_SSL", "TONE_CDMA_MED_PBX_S_X4", "TONE_CDMA_MED_SLS", 
  "TONE_CDMA_MED_SS", "TONE_CDMA_MED_SSL", "TONE_CDMA_MED_SS_2", "TONE_CDMA_MED_S_X4", "TONE_CDMA_NETWORK_BUSY", "TONE_CDMA_NETWORK_BUSY_ONE_SHOTTONE_CDMA_NETWORK_CALLWAITING", 
  "TONE_CDMA_NETWORK_USA_RINGBACK", "TONE_CDMA_ONE_MIN_BEEP", "TONE_CDMA_PIP", "TONE_CDMA_PRESSHOLDKEY_LITE", "TONE_CDMA_REORDER", "TONE_CDMA_SIGNAL_OFF", "TONE_CDMA_SOFT_ERROR_LITE", 
  "TONE_DTMF_0", "TONE_DTMF_1", "TONE_DTMF_2", "TONE_DTMF_3", "TONE_DTMF_4", "TONE_DTMF_5", "TONE_DTMF_6", "TONE_DTMF_7", "TONE_DTMF_8", "TONE_DTMF_9", "TONE_DTMF_A", "TONE_DTMF_B", 
  "TONE_DTMF_C", "TONE_DTMF_D", "TONE_DTMF_P", "TONE_DTMF_S", "TONE_PROP_ACK", "TONE_PROP_BEEP", "TONE_PROP_BEEP2", "TONE_PROP_NACK", "TONE_PROP_PROMPT", "TONE_SUP_BUSY", 
  "TONE_SUP_CALL_WAITING", "TONE_SUP_CONFIRM", "TONE_SUP_CONGESTION", "TONE_SUP_CONGESTION_ABBREV", "TONE_SUP_DIAL", "TONE_SUP_ERROR", "TONE_SUP_INTERCEPT", "TONE_SUP_INTERCEPT_ABBREV", 
  "TONE_SUP_PIP", "TONE_SUP_RADIO_ACK", "TONE_SUP_RADIO_NOTAVAIL", "TONE_SUP_RINGTONE"};

Integer[] tone_numbers = {97, 37, 39, 87, 93, 91, 86, 42, 95, 46, 45, 48, 50, 51, 52, 49, 47, 41, 34, 92, 53, 71, 80, 74, 77, 83, 65, 56, 59, 62, 68, 36, 89, 55, 73, 82, 76, 79, 85, 
  67, 58, 61, 64, 70, 54, 72, 81, 75, 78, 84, 66, 57, 60, 63, 69, 40, 96, 43, 35, 88, 44, 90, 38, 98, 94, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 12, 13, 14, 15, 11, 10, 25, 24, 28, 26, 27, 17, 
  22, 32, 18, 31, 16, 21, 29, 30, 33, 19, 20, 23};

ToneGenerator tonegenerator;
int count;
int duration;
int loudness;
boolean has_started;


void setup() {
  background(0, 0, 200);
  textAlign(CENTER);
  textSize(40);
  duration = 800; // miliseconds
  loudness = 100; // maximum
  tonegenerator = new ToneGenerator(AudioManager.STREAM_MUSIC, loudness );             
  text("Tab to start.", width/2, height/2);
}


void draw() {
  if (has_started) {
    background(0, 0, 200);
    text(tones[count], width/2, height/2);
    text("Value = "+tone_numbers[count], width/2, 3*height/4);
    text("Back", width/4, 15*height/16);
    text("Forward", 3*width/4, 15*height/16);
    float h = 7*height/8;
    stroke(255);
    line(0, h, width, h);
    line(width/2, 7*height/8, width/2, height);
  }
}

void mousePressed() {
  has_started = true;
  if (mouseY > 7*height/8) {
    if (mouseX > width/2) count++;
    else if (count > 0) count--;
  }
  tonegenerator.startTone(tone_numbers[count], duration);
  if (count == tones.length && count < 0) count = 0;
}
