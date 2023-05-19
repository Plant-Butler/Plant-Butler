package com.plant.controller;
import com.plant.utils.MyScheduledService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import java.util.TimeZone;

@RestController
public class MyController {

    private final MyScheduledService myScheduledService;

    public MyController(MyScheduledService myScheduledService) {
        this.myScheduledService = myScheduledService;
    }

    @PostMapping("/schedule")
    public ResponseEntity<Void> scheduleTask(@RequestBody ScheduleRequest request) {
        this.myScheduledService.scheduleTask(request.getCronExpression(), request.getTimeZone());

        return ResponseEntity.ok().build();
    }

    public static class ScheduleRequest {
        private String cronExpression;
        private TimeZone timeZone;

        // getters, setters 생략
    }
}