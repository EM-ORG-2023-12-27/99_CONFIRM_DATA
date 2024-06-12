package com.example.demo.controller;


import com.example.demo.domain.dto.MemoDto;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

@Controller
@Slf4j
@RequestMapping("/memo")
public class MemoController {


    @GetMapping("/get")
    public void get(@ModelAttribute MemoDto memoDto){
        log.info("GET /memo/get...");
    }
    @PostMapping("/post")
    public @ResponseBody String post(@ModelAttribute MemoDto memoDto){
        log.info("POST /memo/post..");

        return "post Test";
    }
    @PostMapping(value = "/post_header",consumes= MediaType.APPLICATION_JSON_VALUE, produces=MediaType.APPLICATION_XML_VALUE)
    public @ResponseBody String post2(@ModelAttribute MemoDto memoDto){
        log.info("POST /memo/post..");

        return "post Test";
    }

    @PutMapping("/put")
    public void put(@ModelAttribute MemoDto memoDto){
        log.info("PUT /memo/put");
    }
    @DeleteMapping("/delete")
    public void delete(@ModelAttribute MemoDto memoDto){
        log.info("DELETE /memo/delete");
    }

}
