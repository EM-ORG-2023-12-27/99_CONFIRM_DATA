package com.example.demo.restcontroller;


import com.example.demo.domain.dto.BoardDto;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@Slf4j
@RequestMapping("/board")
public class BoardRestController {

    @PutMapping("/put")
    public String Put(@RequestBody BoardDto dto)
    {
        log.info("PUT /board/put dto : " + dto);
        return "PUT SUCCESS";
    }

}
