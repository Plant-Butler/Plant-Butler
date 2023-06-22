package com.plant.vo;

public class PestVo {

    private int pestId;
    private String image;
    private String detail;
    private String solution;

    public PestVo() {}

    public PestVo(int pestId, String image, String detail, String solution) {
        this.pestId = pestId;
        this.image = image;
        this.detail = detail;
        this.solution = solution;
    }

    public int getDiseaseId() {
        return pestId;
    }

    public void setDiseaseId(int diseaseId) {
        this.pestId = diseaseId;
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
