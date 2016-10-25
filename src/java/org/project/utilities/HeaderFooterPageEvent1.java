/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package org.project.utilities;
import com.itextpdf.text.Document;
import com.itextpdf.text.Element;
import com.itextpdf.text.Phrase;
import com.itextpdf.text.Rectangle;
import com.itextpdf.text.pdf.ColumnText;
import com.itextpdf.text.pdf.PdfPageEventHelper;
import com.itextpdf.text.pdf.PdfWriter;
/**
 *
 * @author asl
 */
public class HeaderFooterPageEvent1 extends PdfPageEventHelper{
     private String heading1="";
    private String randomkey="";
    
   /* public void onStartPage(PdfWriter writer,Document document) {
    	Rectangle rect = writer.getBoxSize("art");
        ColumnText.showTextAligned(writer.getDirectContent(),Element.ALIGN_CENTER, new Phrase(heading1), rect.getLeft(), rect.getTop(), 0);
        ColumnText.showTextAligned(writer.getDirectContent(),Element.ALIGN_CENTER, new Phrase(randomkey), rect.getRight(), rect.getTop(), 0);
    }*/
    public void onEndPage(PdfWriter writer,Document document) {
    	Rectangle rect = writer.getBoxSize("art");
        ColumnText.showTextAligned(writer.getDirectContent(),Element.ALIGN_CENTER, new Phrase(heading1), rect.getLeft(), rect.getBottom(), 0);
        ColumnText.showTextAligned(writer.getDirectContent(),Element.ALIGN_CENTER, new Phrase(randomkey), rect.getRight(), rect.getBottom(), 0);
    }

    /**
     * @return the heading1
     */
    public String getHeading1() {
        return heading1;
    }

    /**
     * @param heading1 the heading1 to set
     */
    public void setHeading1(String heading1) {
        this.heading1 = heading1;
    }

    /**
     * @return the randomkey
     */
    public String getRandomkey() {
        return randomkey;
    }

    /**
     * @param randomkey the randomkey to set
     */
    public void setRandomkey(String randomkey) {
        this.randomkey = randomkey;
    }
}
