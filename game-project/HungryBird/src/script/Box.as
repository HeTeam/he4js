package script{
import Basic.UI_Box;

public class Box extends UI_Box{
    public function Box() {
        onClick(this,blink)
    }
    public function blink():void {
        m_blinkMV.play();
    }
}
}