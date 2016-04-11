Toy Robot Simulator
====

#Run Application

```
ruby robot.rb commands.txt
```
commands.txt - name of file with commands in this project

-----
#DescriptionThe application is a simulation of a toy robot moving on a square tabletop, of dimensions 5 units x 5 units. 

1. There are no other obstructions on the table surface. 
2. The robot is free to roam around the surface of the table, but must be prevented from falling todestruction.
3. Any movement that would result in the robot falling from the table must be prevented, however further valid movement commands must still be allowed.
4. The first valid command to the robot is a PLACE command, after that, any sequence ofcommands may be issued, in any order, including another PLACE command. The applicationshould discard all commands in the sequence until a valid PLACE command has beenexecuted.
5. A robot that is not on the table can choose the ignore the MOVE, LEFT, RIGHT and REPORTcommands.6. Input can be from a file

Create an application that can read in commands of the following form:

```PLACE X,Y,FMOVELEFTRIGHTREPORT
```
* PLACE will put the toy robot on the table in position X,Y and facing NORTH, SOUTH, EAST orWEST. The origin (0,0) can be considered to be the SOUTH WEST most corner. * MOVE will move the toy robot one unit forward in the direction it is currently facing.* LEFT and RIGHT will rotate the robot 90 degrees in the specified direction without changingthe position of the robot.* REPORT will announce the X,Y and F of the robot. This can be in any form, but standardoutput is sufficient.
