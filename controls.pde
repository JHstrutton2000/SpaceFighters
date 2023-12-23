boolean forward = false;
boolean back    = false;
boolean right   = false;
boolean left    = false;
boolean fire    = false;

void keyPressed() {
  if (key == upKey) {
    forward = true;
  }
  if (key == rightKey) {
    right = true;
  }
  if (key == leftKey) {
    left = true;
  }
  if (key == downKey) {
    back = true;
  }
  if (key == fireKey) {
    fire = true;
  }
}

void keyReleased() {
  if (key == upKey) {
    forward = false;
  }
  if (key == rightKey) {
    right = false;
  }
  if (key == leftKey) {
    left = false;
  }
  if (key == downKey) {
    back = false;
  }
}
