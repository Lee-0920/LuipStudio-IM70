#ifndef UI_FRAME_RESULT_H
#define UI_FRAME_RESULT_H

#include <QWidget>
#include <QLabel>
#include <QString>

namespace UI
{
class ResultWidget : public QWidget
{
    Q_OBJECT
public:
    explicit ResultWidget(QString strName, QString strTarget, QString strResult,
                          QString strDateTime, QString strUnit, QWidget *parent = 0);
    ~ResultWidget();

    void SetResult(const QString strResult, const QString strFlag, QColor clrResult = QColor(255, 255, 255));
    void SetResultInfo(QString name, QString target, QString result, QString dateTime, QString resultType);
    void SetMeasureTarget(QString strTarget);
    void SetMeasureResult(QString strResult);
    void SetMeasureTime(QString strDateTime);
    void SetMeasureResultFont(int fontSize);

protected:
    virtual void paintEvent(QPaintEvent *event);
    virtual void resizeEvent(QResizeEvent *event);

private:
    QLabel * m_nameLabel;         // 名称
    QLabel * m_targetLabel;         // 测量参数类型
    QLabel *m_resultLabel;    //测量结果显示
    QLabel *m_dateLabel;     //测量结果日期
    QLabel *m_timeLabel;     //测量结果时间
    QLabel *m_unitLabel;     // 单位
    void DateTimeStringAnalysis(QString &dateTime, QString &date, QString &time);
    int GetPointSize(QString& text, int limitWidth);
};

}
#endif // UI_FRAME_RESULTITERM_H
