package org.kkk.seleniumcrawler;

import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.kkk.config.RootConfig;
import org.openqa.selenium.By;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.util.FileCopyUtils;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = { RootConfig.class }) // 경로를 적어주면 컴피그로 등록돼서 실행

public class CrawlerTests {
	
	 @Test
    public void testSelenium()throws Exception  {


		ChromeDriver driver = new ChromeDriver();
        System.setProperty("webdriver.chrome.driver", "C:\\zzz\\chromedriver.exe");

        //Convenient
        driver.get("https://together.kakao.com/magazines");

        Thread.sleep(1000);
        JavascriptExecutor jse = (JavascriptExecutor) driver;

        driver.executeScript("window.scrollTo(0, document.body.scrollHeight);", new String[] {});
        
        Thread.sleep(3000);
        
        driver.executeScript("window.scrollTo(0, document.body.scrollHeight);", new String[] {});
        
        Thread.sleep(3000);
        
        
        //List<WebElement> list = driver.findElements(By.className("list_official"));
        
        List<WebElement> imgList = driver.findElements(By.cssSelector(".list_official img"));
        List<WebElement> strongList = driver.findElements(By.cssSelector(".subject_official"));

        
        for (WebElement webElement : imgList) {

            //System.out.println(webElement.getText());
        	
            System.out.println("-----------------------------------1");
            System.out.println(imgList);
            System.out.println("-----------------------------------2");
          
        }
        
        strongList.forEach(s -> {
    		String subStr = s.getText();
    		
    		System.out.println(subStr);
    	});
        
        

        	imgList.forEach(e -> {
        		String imgSrc = e.getAttribute("src");
        		
        		
        		
        		System.out.println("============================");
        		System.out.println(imgSrc);
        	    
       		
        		
            	try {
            		UUID uuid = UUID.randomUUID();
            		URL url = new URL(imgSrc);
            		
            		InputStream in = url.openStream();
            		
            		OutputStream fout = new FileOutputStream("C:\\zzz\\test\\img" + uuid +".png");
            		
            		FileCopyUtils.copy(in, fout);
            		
            	}catch(Exception e2) {
            		e2.printStackTrace();
            	}
            	
        	});
        	
        
     
    }
}