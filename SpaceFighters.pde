ArrayList<GameObject> gameObjects;
int maxPriorityIndex =0;

void setup() {
  size(400, 400);

  gameObjects = new ArrayList<GameObject>();

  gameObjects.add(new Ship(new PVector(50, 100), new PVector(100, 100, 100), true));
  gameObjects.add(new Ship(new PVector(100, 100), new PVector(100, 100, 100), false));
}

void draw() {
  update();

  for (int priorityIndex =0; priorityIndex <= maxPriorityIndex; priorityIndex++) {
    if (priorityIndex == 0) {
      background(BackgroundColor);
    }

    for (int i=0; i<gameObjects.size(); i++) {
      if (maxPriorityIndex <= gameObjects.get(i).getPriority()) {
        maxPriorityIndex = gameObjects.get(i).getPriority();
      }

      if (priorityIndex == gameObjects.get(i).getPriority()) {
        gameObjects.get(i).draw();
      }
    }
  }
}

void update() {
  for (int i=0; i<gameObjects.size(); i++) {
    if (gameObjects.get(i).isDead()) {
      gameObjects.remove(i);
    } else {
      gameObjects.get(i).update();
      for (int j=0; j<gameObjects.size(); j++) {
        if (i != j && gameObjects.get(i).isColliding(gameObjects.get(j))) {
          break;
        }
      }
    }
  }
}
