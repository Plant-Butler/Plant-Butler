package com.plant.service;

import com.google.firebase.messaging.FirebaseMessaging;
import com.google.firebase.messaging.FirebaseMessagingException;
import com.google.firebase.messaging.Message;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.TaskScheduler;
import org.springframework.scheduling.support.CronTrigger;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;

import java.util.concurrent.ScheduledFuture;

@Service
public class webpushService {

    private MyPlantService myPlantService;

    @Autowired
    private UserService userService;
    private final TaskScheduler taskScheduler;

    private final ScheduleService scheduleService = new ScheduleService();
    private Map<String, ScheduledFuture<?>> scheduledTasks = new HashMap<>();

    public webpushService(TaskScheduler taskScheduler ,MyPlantService myPlantService) {
        this.taskScheduler = taskScheduler;
        this.myPlantService = myPlantService;
    }

    public void scheduleTask(int myplantId,String water, String cronExpression,String[] token) {
        CronTrigger cronTrigger = new CronTrigger(cronExpression);
        ScheduledFuture<?> scheduledTask = this.taskScheduler.schedule(() -> doScheduledTask1(token), cronTrigger);

        String key = myplantId + "_" + water;
        System.out.println("ScheduleTask key: " + key);

        this.scheduledTasks.put(key, scheduledTask);
    }

    public void scheduleTask2(int myplantId,String drug, String cronExpression,String[] token) {
        CronTrigger cronTrigger = new CronTrigger(cronExpression);
        ScheduledFuture<?> scheduledTask = this.taskScheduler.schedule(() -> doScheduledTask2(token), cronTrigger);

        String key = myplantId + "_" + drug;

        this.scheduledTasks.put(key, scheduledTask);
    }

    private void doScheduledTask1(String[] tokens) {
        for(String token : tokens) {
            Message message = Message.builder()
                    .putData("score", "물주기 알림이 도착")
                    .putData("time", "설정해두신 물주기 시간이 경과했습니다!")
                    .setToken(token)
                    .build();
            try {
                String response = FirebaseMessaging.getInstance().send(message);
                System.out.println("Successfully sent message: " + response);
            } catch (FirebaseMessagingException e) {
                System.err.println("Failed to send message to token: " + token);
                e.printStackTrace();
                try {
                    userService.deleteToken(token);
                    System.out.println("Deleted invalid token: " + token);
                } catch (Exception ex) {
                    System.err.println("Failed to delete token: " + token);
                    ex.printStackTrace();
                }
            }
        }
    }

    private void doScheduledTask2(String[] tokens) {
        for(String token : tokens) {
            Message message = Message.builder()
                    .putData("score", " 영양제 주기 알림이 도착")
                    .putData("time", "설정해두신 영양제 주기 시간이 경과했습니다!")
                    .setToken(token)
                    .build();
            try {
                String response = FirebaseMessaging.getInstance().send(message);
                System.out.println("Successfully sent message: " + response);
            } catch (FirebaseMessagingException e) {
                System.err.println("Failed to send message to token: " + token);
                e.printStackTrace();
                try {
                    userService.deleteToken(token);
                    System.out.println("Deleted invalid token: " + token);
                } catch (Exception ex) {
                    System.err.println("Failed to delete token: " + token);
                    ex.printStackTrace();
                }
            }
        }
    }

    public void cancelTask(int myplantId,String key) {
        System.out.println("CancelTask key: " + key);
        ScheduledFuture<?> scheduledTask = this.scheduledTasks.get(key);
        System.out.println(scheduledTask);
        if (scheduledTask != null) {
            scheduledTask.cancel(false);
            this.scheduledTasks.remove(key);
            myPlantService.deleteSchedule(myplantId);

        }
    }

    public void cancelTask2(int myplantId, String key) {
        ScheduledFuture<?> scheduledTask = this.scheduledTasks.get(key);
        if (scheduledTask != null) {
            scheduledTask.cancel(false);
            this.scheduledTasks.remove(key);
            myPlantService.deleteSchedule2(myplantId);

        }
    }
}
