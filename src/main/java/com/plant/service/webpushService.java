package com.plant.service;

import com.google.firebase.messaging.FirebaseMessaging;
import com.google.firebase.messaging.FirebaseMessagingException;
import com.google.firebase.messaging.Message;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.TaskScheduler;
import org.springframework.scheduling.support.CronTrigger;
import org.springframework.stereotype.Service;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.ScheduledFuture;

@Service
public class webpushService {

    @Autowired
    private UserService userService;
    private final TaskScheduler taskScheduler;

    private final ScheduleService scheduleService = new ScheduleService();
    private final Map<Integer, ScheduledFuture<?>> scheduledTasks = new ConcurrentHashMap<>();

    public webpushService(TaskScheduler taskScheduler) {
        this.taskScheduler = taskScheduler;
    }

    public void scheduleTask(int myplantId, String cronExpression,String[] token) {
        CronTrigger cronTrigger = new CronTrigger(cronExpression);
        ScheduledFuture<?> scheduledTask = this.taskScheduler.schedule(() -> doScheduledTask(token), cronTrigger);

        this.scheduledTasks.put(myplantId, scheduledTask);
    }

    private void doScheduledTask(String[] tokens) {
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

    public void cancelTask(int myplantId) {
        ScheduledFuture<?> scheduledTask = this.scheduledTasks.get(myplantId);
        if (scheduledTask != null) {
            scheduledTask.cancel(false);
            this.scheduledTasks.remove(myplantId);
        }
    }
}
