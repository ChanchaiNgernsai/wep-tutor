package com.springmvc.model;

import java.util.Date;
import javax.persistence.*;

@Entity
@Table(name = "reports")
public class Report {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "report_id")
    private int reportId;

    @Column(name = "report_description", length = 100)
    private String reportDescription;

    @Temporal(TemporalType.DATE)
    @Column(name = "report_date")
    private Date reportDate;

    @Column(name = "status")
    private int status;

    @ManyToOne
    @JoinColumn(name = "reporter_email")
    private User reporter;

    @ManyToOne
    @JoinColumn(name = "reported_role_id")
    private Tutor reported;

    @ManyToOne
    @JoinColumn(name = "course_id")
    private Course course;

    public Course getCourse() {
        return course;
    }

    public void setCourse(Course course) {
        this.course = course;
    }

    public Report() {
    }

    public Report(String reportDescription, Date reportDate, int status) {
        this.reportDescription = reportDescription;
        this.reportDate = reportDate;
        this.status = status;
    }

    public int getReportId() {
        return reportId;
    }

    public void setReportId(int reportId) {
        this.reportId = reportId;
    }

    public String getReportDescription() {
        return reportDescription;
    }

    public void setReportDescription(String reportDescription) {
        this.reportDescription = reportDescription;
    }

    public Date getReportDate() {
        return reportDate;
    }

    public void setReportDate(Date reportDate) {
        this.reportDate = reportDate;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public User getReporter() {
        return reporter;
    }

    public void setReporter(User reporter) {
        this.reporter = reporter;
    }

    public Tutor getReported() {
        return reported;
    }

    public void setReported(Tutor reported) {
        this.reported = reported;
    }

}
