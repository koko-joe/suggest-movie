package de.renekokott.suggestmovie;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@SpringBootApplication
@Controller
public class SuggestmovieApplication {

	@RequestMapping("/")
    @ResponseBody
    String home() {
		return "Hello World!";
    }

	public static void main(String[] args) {
		SpringApplication.run(SuggestmovieApplication.class, args);
	}

}
