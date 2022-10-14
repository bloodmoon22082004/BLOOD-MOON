# By MOON

# Acknowledgement to the original authors of the code on which this 
# example is based.
import pygame
import random

SCREEN_HEIGHT = 400
SCREEN_WIDTH = 400

screen = pygame.display.set_mode((SCREEN_WIDTH, SCREEN_HEIGHT))
done = False
is_blue = True
x = 30
y = 30

time = pygame.time

while not done:
        
        for event in pygame.event.get():
               
                if event.type == pygame.QUIT:
                        done = True
                if event.type == pygame.KEYDOWN and event.key == pygame.K_SPACE:
                        is_blue = not is_blue
        
        pressed = pygame.key.get_pressed()

       
        if (pressed[pygame.K_LEFT]) and (x > 0): 
                x -= 0.1
        elif (pressed[pygame.K_RIGHT]) and (x <= 340): 
                x += 0.1
        elif (pressed[pygame.K_UP]) and (y > 0): 
                y -= 0.1
        elif (pressed[pygame.K_DOWN]) and (y <= 340):
                y += 0.1
        if (time.get_ticks() % 1000 == 0) and (random.randint(1, 5) <= 2):
                print(f"x is {x:.1f} y is {y:.1f} timer is {time.get_ticks()}")

        screen.fill((0, 0, 0))
        if is_blue: color = (0, 128, 255)
        else: color = (255, 100, 0)

        rect = pygame.Rect(x, y, 60, 60)
        pygame.draw.rect(screen, color, rect)

        pygame.display.flip()
