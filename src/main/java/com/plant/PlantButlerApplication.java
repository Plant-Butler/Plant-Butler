package com.plant;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;

@EnableScheduling
@SpringBootApplication
public class PlantButlerApplication {

	public static void main(String[] args) {
		SpringApplication.run(PlantButlerApplication.class, args);
	}
	
}
