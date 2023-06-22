package com.plant.service;

import com.google.firebase.messaging.FirebaseMessaging;
import com.google.firebase.messaging.FirebaseMessagingException;
import com.google.firebase.messaging.Message;
import com.plant.vo.TokenVo;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.scheduling.TaskScheduler;
import org.springframework.scheduling.support.CronTrigger;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;

import java.util.concurrent.ScheduledFuture;

@Service
public class webpushService {

    private final MyPlantService myPlantService;

    private final UserService userService;
    private final TaskScheduler taskScheduler;

    private final ScheduleService scheduleService;
    private final TokenRepository tokenRepository;

    private Map<String, ScheduledFuture<?>> scheduledTasks = new HashMap<>();
    private Logger logger = LoggerFactory.getLogger(this.getClass());

    public webpushService(TaskScheduler taskScheduler , TokenRepository tokenRepository, UserService userService, MyPlantService myPlantService, ScheduleService scheduleService) {
        this.taskScheduler = taskScheduler;
        this.userService = userService;
        this.myPlantService = myPlantService;
        this.scheduleService = scheduleService;
        this.tokenRepository = tokenRepository;
    }

    public void scheduleTask(int myplantId,String water, String cronExpression,String[] token) {
        CronTrigger cronTrigger = new CronTrigger(cronExpression);
        ScheduledFuture<?> scheduledTask = this.taskScheduler.schedule(() -> doScheduledTask1(token), cronTrigger);

        String key = myplantId + "_" + water;
        System.out.println("ScheduleTask key: " + key);

        this.scheduledTasks.put(key, scheduledTask);
        System.out.println("Scheduled tasks: " + this.scheduledTasks);
    }

    public void scheduleTask2(int myplantId,String drug, String cronExpression,String[] token) {
        CronTrigger cronTrigger = new CronTrigger(cronExpression);
        ScheduledFuture<?> scheduledTask = this.taskScheduler.schedule(() -> doScheduledTask2(token), cronTrigger);

        String key = myplantId + "_" + drug;

        this.scheduledTasks.put(key, scheduledTask);


    }
    public void scheduleTask3(int myplantId,String cut, String cronExpression,String[] token) {
        CronTrigger cronTrigger = new CronTrigger(cronExpression);
        ScheduledFuture<?> scheduledTask = this.taskScheduler.schedule(() -> doScheduledTask3(token), cronTrigger);

        String key = myplantId + "_" + cut;

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
                logger.info("message:" + message.toString());
                String response = FirebaseMessaging.getInstance().send(message);
                logger.info("Successfully sent message: " + response);
            } catch (FirebaseMessagingException e) {
                logger.info("Failed to send message to token: " + token);
                logger.error(e.getMessage(), e);
                try {
                    TokenVo tokenVo = tokenRepository.findByTokenNum(token);
                    tokenRepository.delete(tokenVo);
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
    private void doScheduledTask3(String[] tokens) {
        for(String token : tokens) {
            Message message = Message.builder()
                    .putData("score", " 가지치기 알림이 도착")
                    .putData("time", "설정해두신 가지치기 시간이 경과했습니다!")
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
    public void cancelTask3(int myplantId, String key) {
        ScheduledFuture<?> scheduledTask = this.scheduledTasks.get(key);
        if (scheduledTask != null) {
            scheduledTask.cancel(false);
            this.scheduledTasks.remove(key);
            myPlantService.deleteSchedule3(myplantId);

        }
    }
}
