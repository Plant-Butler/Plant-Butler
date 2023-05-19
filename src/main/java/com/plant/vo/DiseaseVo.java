package com.plant.vo;

public class DiseaseVo {

    private int diseaseId;
    private String image;
    private String detail;
    private String solution;

    public DiseaseVo() {}

    public DiseaseVo(int diseaseId, String image, String detail, String solution) {
        this.diseaseId = diseaseId;
        this.image = image;
        this.detail = detail;
        this.solution = solution;
    }

    public int getDiseaseId() {
        return diseaseId;
    }

    public void setDiseaseId(int diseaseId) {
        this.diseaseId = diseaseId;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getDetail() {
        return detail;
    }

    public void setDetail(String detail) {
        this.detail = detail;
    }

    public String getSolution() {
        return solution;
    }

    public void setSolution(String solution) {
        this.solution = solution;
    }
}
