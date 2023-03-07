import de.bezier.guido.*;
public final static int NUM_ROWS = 5;
public final static int NUM_COLS = 5;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> mines = new ArrayList <MSButton>(); //ArrayList of just the minesweeper buttons that are mined

void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    
    //your code to initialize buttons goes here
    buttons = new MSButton[NUM_ROWS][NUM_COLS];
    for(int k = 0; k < NUM_ROWS; k++){
      for(int i = 0; i < NUM_COLS; i++){
        buttons [k][i] = new MSButton(k,i);
      }
    }
    
    
    setMines();
    setMines();
    setMines();
    setMines();
}
public void setMines()
{
    int r = (int)(Math.random()*NUM_ROWS);
    int c = (int)(Math.random()*NUM_COLS);
    if(!mines.contains(buttons[r][c]))
      mines.add(buttons[r][c]);
    System.out.println(r + ", " + c);
}

public void draw ()
{
    background( 0 );
    if(isWon() == true)
        displayWinningMessage();
}
public boolean isWon()
{
    //your code here
    return false;
}
public void displayLosingMessage()
{
    //your code here
    System.out.println("Lose");
}
public void displayWinningMessage()
{
    //your code here
}
public boolean isValid(int r, int c)
{
    if((r < NUM_ROWS && r >= 0) && (c < NUM_COLS && c >= 0))
      return true;
     return false;
}
public int countMines(int row, int col)
{
    int numMines = 0;
    if(isValid(row-1,col-1) == true && mines.contains(buttons[row-1][col-1]))
      numMines++;
    if(isValid(row-1,col) == true && mines.contains(buttons[row-1][col]))
      numMines++;
    if(isValid(row-1,col+1) == true && mines.contains(buttons[row-1][col+1]))
      numMines++;
    if(isValid(row,col-1) == true && mines.contains(buttons[row][col-1]))
      numMines++;
    if(isValid(row,col+1) == true && mines.contains(buttons[row][col+1]))
      numMines++;
    if(isValid(row+1,col-1) == true && mines.contains(buttons[row+1][col-1]))
      numMines++;
    if(isValid(row+1,col) == true && mines.contains(buttons[row+1][col]))
      numMines++;
    if(isValid(row+1,col+1) == true && mines.contains(buttons[row+1][col+1]))
      numMines++;
    return numMines;
}
public class MSButton
{
    private int myRow, myCol;
    private float x,y, width, height;
    private boolean clicked, flagged;
    private String myLabel;
    
    public MSButton ( int row, int col )
    {
        width = 400/NUM_COLS;
        height = 400/NUM_ROWS;
        myRow = row;
        myCol = col; 
        x = myCol*width;
        y = myRow*height;
        myLabel = "";
        flagged = clicked = false;
        Interactive.add( this ); // register it with the manager
    }

    // called by manager
    public void mousePressed () 
    {
      
      //  if(flagged == true){
      //   flagged = false;
      //   if(isValid(myRow-1,myCol-1) && buttons[myRow-1][myCol-1].isFlagged()){
      //     buttons[myRow-1][myCol-1].mousePressed();
      //   }
      //  }
        
        //Known issues/things to work on: [maybe NOT solved?] Sometimes generated one mine less than requested, sometimes mines won't have any surrounding numbers, only on col 1?
        //Recursion works, just issue of getting it to stop and reveal numbers.
        //[ISSUE SOLVED] Problem was in isValid. specific issue with either countMines or setMines which for some reason does not detect mines when in the 0 column
      
        clicked = true;
        if(mouseButton == RIGHT){
          flagged = !flagged;
        if(flagged == false)
          clicked = false;
        }
        else if(mines.contains(this))
          displayLosingMessage();
        else if(countMines(myRow,myCol) > 0)
          setLabel(countMines(myRow,myCol));
          
          //buttons[myRow-1][myCol-1].mousePressed();
    }
        

    public void draw () 
    {    
        if (flagged)
            fill(0);
        else if( clicked && mines.contains(this) ) 
            fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(myLabel,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        myLabel = newLabel;
    }
    public void setLabel(int newLabel)
    {
        myLabel = ""+ newLabel;
    }
    public boolean isFlagged()
    {
        return flagged;
    }
}
