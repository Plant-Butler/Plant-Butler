package com.plant.utils;

import org.springframework.scheduling.TaskScheduler;
import org.springframework.scheduling.support.CronTrigger;
import org.springframework.stereotype.Service;

import java.util.TimeZone;

@Service
public class MyScheduledService {

    private final TaskScheduler taskScheduler;

    public MyScheduledService(TaskScheduler taskScheduler) {
        this.taskScheduler = taskScheduler;
    }

    public void scheduleTask(String cronExpression, TimeZone timeZone) {
        CronTrigger cronTrigger = new CronTrigger(cronExpression, timeZone);

        this.taskScheduler.schedule(this::doScheduledTask, cronTrigger);
    }

    // 이 메서드가 사용자가 원하는 시간에 실행됩니다.
    private void doScheduledTask() {
        // TODO: 원하는 작업 수행
    }
}