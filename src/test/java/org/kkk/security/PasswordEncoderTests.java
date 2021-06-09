package org.kkk.security;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.kkk.config.RootConfig;
import org.kkk.config.SecurityConfig;
import org.kkk.config.ServletConfig;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;


import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = {RootConfig.class,SecurityConfig.class})
@Log4j
public class PasswordEncoderTests {

	@Autowired
	private PasswordEncoder pwEncoder;
	
	@Test
	public void testEncode() {
		
		String str = "member";
		
		String enStr = pwEncoder.encode(str);
		
		//$2a$10$yBttkgBXtl6XWUtMk6Q.Me5puWgfGlTnX0lmo5E0.cfqjPv2oyGaa
		log.info("enstr : " + enStr);
	}
	
}
