package com.plant.vo;

import java.sql.Timestamp;

public class DiaryVo {

    private int diaryId;

    private String userId;

    private String diaryTitle;
    private String diaryImage;
    private String diaryPraiseRegret;
    private String diaryEmotion;
    private String diaryGrowth;
    private String diaryContent;
    private Timestamp diaryDate;

    public DiaryVo() {}

    public DiaryVo(int diaryId, String userId, String diaryTitle, String diaryImage, String diaryPraiseRegret, String diaryEmotion, String diaryGrowth, String diaryContent, Timestamp diaryDate) {
        this.diaryId = diaryId;
        this.userId = userId;
        this.diaryTitle = diaryTitle;
        this.diaryImage = diaryImage;
        this.diaryPraiseRegret = diaryPraiseRegret;
        this.diaryEmotion = diaryEmotion;
        this.diaryGrowth = diaryGrowth;
        this.diaryContent = diaryContent;
        this.diaryDate = diaryDate;
    }

    public int getDiaryId() {
        return diaryId;
    }

    public void setDiaryId(int diaryId) {
        this.diaryId = diaryId;
    }

    public String getDiaryTitle() {
        return diaryTitle;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public void setDiaryTitle(String diaryTitle) {
        this.diaryTitle = diaryTitle;
    }

    public String getDiaryImage() {
        return diaryImage;
    }

    public void setDiaryImage(String diaryImage) {
        this.diaryImage = diaryImage;
    }

    public String getDiaryPraiseRegret() {
        return diaryPraiseRegret;
    }

    public void setDiaryPraiseRegret(String diaryPraiseRegret) {
        this.diaryPraiseRegret = diaryPraiseRegret;
    }

    public String getDiaryEmotion() {
        return diaryEmotion;
    }

    public void setDiaryEmotion(String diaryEmotion) {
        this.diaryEmotion = diaryEmotion;
    }

    public String getDiaryGrowth() {
        return diaryGrowth;
    }

    public void setDiaryGrowth(String diaryGrowth) {
        this.diaryGrowth = diaryGrowth;
    }

    public String getDiaryContent() {
        return diaryContent;
    }

    public void setDiaryContent(String diaryContent) {
        this.diaryContent = diaryContent;
    }

    public Timestamp getDiaryDate() {
        return diaryDate;
    }

    public void setDiaryDate(Timestamp diaryDate) {
        this.diaryDate = diaryDate;
    }
}
