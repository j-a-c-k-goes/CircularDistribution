// CircularDistribution/sketch.pde
PFont panamera;
color fg = #ffffffff;
color bg = #192019;
String word;
public void setup() {
  panamera = createFont("Panamera-Regular.otf", 24);
  size(1280, 720);
  textFont(panamera);
  textAlign(LEFT, CENTER);
  frameRate(60);
}
public void draw() {
  int seconds = second();
  int amount = frameCount;
  background(bg);
  fill(fg);
  pushMatrix();
  translate(width / 2, height / 2);
  if (frameCount % 24 == 0) {
    word = "™®";
  } else if (frameCount % 24 != 0) {
    word = "®™";
  }
  for (int i = 0; i < word.length(); i++) {
    textWidth(word.charAt(i));
  }
  for (int i = 0; i < amount; ++i) {
    int step = controlStep(width, 2 * i, amount);
    float rotation = step * i * 0.0025 * (step * (i + 1) );
    float wave = makeTanWave(15000, rotation, i);
    float fontSize = controlFont(i/(1+i), 2*i, 0.25);
    pushMatrix();
    textSize(fontSize);
    rotate(tanRotation(rotation, wave));
    text(word, rotation * wave, rotation / wave);
    popMatrix();
  }
  popMatrix();
  export(60);
}

private float controlFont(float valueA, int valueB, float valueC) {
  int second = second();
  return (valueA + valueB * second * valueC);
}
private int controlStep(int valueA, int modifier, int valueB) {
  return (valueA * modifier / valueB);
}
private float makeTanWave(int intValueInThousands, float rotationValue, int loopValue) {
  return tan( radians( frameCount - intValueInThousands * rotationValue / intValueInThousands * loopValue));
}
private float tanRotation(float roationValue, float waveValue) {
  return tan(radians( roationValue - ( frameCount * waveValue )));
}
public void export(int outputDuration) {
  int framesToMake = outputDuration * int(frameRate);
  saveFrame("out/rTM_Sketch_####.jpg");
  if (frameCount > framesToMake) {
    exit();
  }
}
