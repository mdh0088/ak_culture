package ak_culture.classes;

public class MobileAppData {
    
    String itemDesc = "";
    
    int length = 0;
    
    String blankStr = ""; //" ", "0"
    
    String order = ""; //R : Right Shift, L : Left Shift
     
    String text = "";
    
    String changedText = "";
    
    MobileAppData() {
        
    }
    
    MobileAppData(String itemDesc, int length, String blankStr, String order, String text) {
        
        this.itemDesc = itemDesc;
        this.length = length;
        this.blankStr = blankStr;
        this.order = order;
        this.text = text;
        
    }
    
    public void setElement(String itemDesc, int length, String blankStr, String order, String text) {
        
        this.itemDesc = itemDesc;
        this.length = length;
        this.blankStr = blankStr;
        this.order = order;
        this.text = text;
        
    }    
    
    public void setText(String text)
    {
        this.text = text;
    }
    
    public void justifyText()
    {
        int diffLength = length - text.length();
        String str = "";
        String spaceStr = "";
        
        if (diffLength == 0) {
            setChangedText(text);
            return;
        }
        
        for ( int i = 1; i <= diffLength; i++) {
            spaceStr += blankStr; 
        }
        
        if (this.text == null || this.text.equals(""))
        {
            setAllTextToBlank(spaceStr);
        } 
        else
        {
            if ("R".equals(order)) {
                str = spaceStr + this.text;
            } else if ("L".equals(order)) {
                str = this.text + spaceStr;
            }
            
            setChangedText(str);
        }
      
    }
    
    public void setAllTextToBlank(String str)
    {
        this.changedText = str;
    }
    
    public void setChangedText(String str)
    {
        this.changedText = str;
    }
    
    public String getChangedText()
    {
        return changedText;
    }
    

}

