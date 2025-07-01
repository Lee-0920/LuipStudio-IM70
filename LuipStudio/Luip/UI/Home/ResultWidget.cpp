#include <QLabel>
#include <QGroupBox>
#include <QVBoxLayout>
#include <QHBoxLayout>
#include <QPainter>
#include <QStyleOption>
#include "ResultWidget.h"
#include <QResizeEvent>
#include <QDebug>
//#include "UI/Frame/MacrosuUI.h"

#ifdef _CS_X86_WINDOWS
#define FONT_SIZE_UI                                    11          //界面的字体大小
#define FONT_SIZE_HEADER                                11          //表头的字体大小
#define FONT_SIZE_CONTENT                               11          //页面内容的字体大小
#define FONT_SIZE_TITLE                                 11          //主菜单栏字体
#else
#define FONT_SIZE_UI                                    8          //界面的字体大小
#define FONT_SIZE_HEADER                                8          //表头的字体大小
#define FONT_SIZE_CONTENT                               8          //页面内容的字体大小
#define FONT_SIZE_TITLE                                 8          //主菜单栏字体
#endif

#define MIX_FONT_PIXEL_SIZE 45

#define RESULT_MAX_SIZE   15

//边界调试，显示主界面黑框中的三个框分别在什么位置
#define BORDER_DEBUG        0

namespace UI
{

ResultWidget::ResultWidget(QString strName, QString strTarget, QString strResult,
                           QString strDateTime, QString strUnit, QWidget *parent)
    : QWidget(parent)
{
    QFont font;                           //字体
    font.setPointSize(15);                //字体大小

    //    this->setFixedSize(230, 110);
//    this->setAutoFillBackground(true);
    this->setObjectName(QStringLiteral("meaResultWidget"));

    m_nameLabel  = new QLabel(this);
#if BORDER_DEBUG
    m_nameLabel->setStyleSheet("QLabel{"
                                "background-color:white;"
                                "}");
#endif
    m_nameLabel->setObjectName(QStringLiteral("measureLabel"));
    m_nameLabel->setFont(font);
    m_nameLabel->setFixedSize(100, 30);
    m_nameLabel->setAlignment(Qt::AlignVCenter | Qt::AlignLeft);
    m_nameLabel->setText(strName);

    m_targetLabel  = new QLabel(this);
#if BORDER_DEBUG
    m_targetLabel->setStyleSheet("QLabel{"
                                "background-color:white;"
                                "}");
#endif
    m_targetLabel->setObjectName(QStringLiteral("measureLabel"));
    QFont targetFont = m_targetLabel->font();
    targetFont.setPointSize(11);
    targetFont.setWeight(QFont::DemiBold);
    m_targetLabel->setFont(targetFont);
    m_targetLabel->setFixedSize(50, 20);
    m_targetLabel->setAlignment(Qt::AlignBottom | Qt::AlignRight);
    m_targetLabel->setText(strTarget);

    QString strDate = "";
    QString strTime = "";

    DateTimeStringAnalysis(strDateTime, strDate, strTime);

    m_dateLabel = new QLabel(this);
#if BORDER_DEBUG
    m_dateLabel->setStyleSheet("QLabel{"
                                 "background-color:red;"
                                 "}");
#endif
    m_dateLabel->setObjectName(QStringLiteral("measureLabel"));
    QFont dateFont = m_dateLabel->font();
    dateFont.setPointSize(12);
    dateFont.setWeight(QFont::DemiBold);
    m_dateLabel->setFont(dateFont);
    m_dateLabel->setFixedSize(180,30);
    m_dateLabel->setAlignment(Qt::AlignVCenter | Qt::AlignHCenter);
    m_dateLabel->setText(strDateTime);

    m_timeLabel = new QLabel();
#if BORDER_DEBUG
    m_timeLabel->setStyleSheet("QLabel{"
                                 "background-color:white;"
                                 "}");
#else
    m_timeLabel->setObjectName(QStringLiteral("measureLabel"));
#endif
    m_timeLabel->setFixedSize(90,30);
    m_timeLabel->setFont(font);
    m_timeLabel->setAlignment(Qt::AlignVCenter | Qt::AlignLeft);
    m_timeLabel->setText(strTime);

    m_resultLabel = new QLabel(this);
#if BORDER_DEBUG
    m_resultLabel->setStyleSheet("QLabel{"
                                 "background-color:red;"
                                 "}");
#endif
    m_resultLabel->setObjectName(QStringLiteral("measureLabel"));
    QFont resultFont = m_resultLabel->font();
    resultFont.setPointSize(17);
    resultFont.setWeight(QFont::DemiBold);
    m_resultLabel->setFont(resultFont);
    m_resultLabel->setFixedSize(150, 60);
    m_resultLabel->setAlignment(Qt::AlignCenter);
    m_resultLabel->setText(strResult);

    m_unitLabel = new QLabel(this);
#if BORDER_DEBUG
    m_unitLabel->setStyleSheet("QLabel{"
                                 "background-color:white;"
                                 "}");
#endif
    m_unitLabel->setObjectName(QStringLiteral("measureLabel"));
    QFont unitFont = m_unitLabel->font();
    unitFont.setPointSize(12);
    unitFont.setWeight(QFont::DemiBold);
    m_unitLabel->setFont(unitFont);
    m_unitLabel->setFixedSize(50, 25);
    m_unitLabel->setAlignment(Qt::AlignTop | Qt::AlignRight);
    m_unitLabel->setText(strUnit);

    QHBoxLayout *nameLayout = new QHBoxLayout();
    nameLayout->addWidget(m_nameLabel);
    nameLayout->addStretch();

    QVBoxLayout *targetLayout = new QVBoxLayout();
    targetLayout->addStretch();
    targetLayout->addWidget(m_targetLabel);
    targetLayout->addWidget(m_unitLabel);
//    targetLayout->addStretch();
    targetLayout->setContentsMargins(0, 0, 0, 0);

    QHBoxLayout *resultLayout = new QHBoxLayout();
    resultLayout->addStretch();
    resultLayout->addWidget(m_resultLabel);
    resultLayout->addLayout(targetLayout);
    resultLayout->setContentsMargins(0, 0, 0, 0);

    QHBoxLayout *unitLayout = new QHBoxLayout();
    unitLayout->addStretch();
    unitLayout->addWidget(m_dateLabel);
//    unitLayout->addWidget(m_timeLabel);
    unitLayout->addStretch();
//    unitLayout->addStretch();

    QVBoxLayout *mainLayout = new QVBoxLayout();
    mainLayout->addStretch();
    mainLayout->addLayout(nameLayout);
    mainLayout->addStretch();
    mainLayout->addLayout(resultLayout);
    mainLayout->addStretch();
    mainLayout->addLayout(unitLayout);
    mainLayout->addStretch();
    mainLayout->setSpacing(10);
    mainLayout->setContentsMargins(10, 10, 10, 10);

    this->setLayout(mainLayout);
}

ResultWidget::~ResultWidget()
{

}

void ResultWidget::SetResult(QString strResult, const QString strFlag, QColor clrResult)
{
//    qDebug() << clrResult;
//    QPalette palette;/* = m_resultLabel->palette();*/
//    palette.setColor(QPalette::WindowText, clrResult);
//    m_resultLabel->setPalette(palette);
//    int nFontSize = m_resultLabel->font().pixelSize();
//    QString str = "color : ";
//    str += QString("rgb(%1, %2, %3);font: bold %4px;").arg(clrResult.red())
//                                                      .arg(clrResult.green())
//                                                      .arg(clrResult.blue())
//                                                      .arg(nFontSize);
//    m_resultLabel->setStyleSheet(str);
    m_resultLabel->setText(strResult);
    m_dateLabel->setText(strFlag);

}

void ResetFontAgain(QWidget* pWidget, const int nSize, bool bIsIgnoreLimit = false);

void ResultWidget::SetResultInfo(QString name,QString target, QString result, QString dateTime, QString resultType)
{
    m_targetLabel->setText(target);
    m_resultLabel->setText(result);
    m_dateLabel->setText(dateTime);
}

void ResultWidget::paintEvent(QPaintEvent *event)
{
//    QPainter painter(this);
//    painter.setRenderHint(QPainter::Antialiasing);  // 反锯齿;
//    painter.setBrush(QBrush(QColor(47,74,157)));/*131, 127, 187*/
//    painter.setPen(Qt::transparent);
//    QRect rect = this->rect();
////    rect.setWidth(rect.width() - 1);
////    rect.setHeight(rect.height() - 1);
//    painter.drawRoundedRect(rect, 5, 5);

//    QWidget::paintEvent(event);
    Q_UNUSED(event)

    QStyleOption opt;
    opt.init(this);
    QPainter painter(this);
    style()->drawPrimitive(QStyle::PE_Widget, &opt, &painter, this);
}

void ResultWidget::resizeEvent(QResizeEvent *event)
{
    int nWidth = event->size().width() * 0.8 / 2.0 ;
    int nHeight = event->size().height() * 0.8 / 4.0;

//    m_targetLabel->setFixedSize(nWidth * 2, nHeight);
//    m_resultLabel->setFixedSize(nWidth * 2, nHeight * 2);
//    m_dateLabel->setFixedSize(nWidth , nHeight);
//    m_timeLabel->setFixedSize(nWidth, nHeight);
//    m_unitLabel->setFixedSize(nWidth, nHeight);

//    ResetFontAgain(m_targetLabel, m_targetLabel->text().size());
//    ResetFontAgain(m_dateLabel, 3);
//    ResetFontAgain(m_timeLabel, 8);
//    ResetFontAgain(m_resultLabel, 3, false);
//    ResetFontAgain(m_unitLabel, 3);

    QWidget::resizeEvent(event);
}

bool ReviseTextPointSizeByWidgetSize(const int nWidth, const int nHeight, const int nStringSize, int &nPixelSize, bool bIsIgnoreLimit = false)
{
    if (nWidth <= 0 || nHeight <= 0 || nStringSize <= 0 )
    {
        return false;
    }

    int nFontWidth = nWidth * 0.9 / nStringSize;
    if (nFontWidth <= 0)
    {
        return false;
    }

    if (false == bIsIgnoreLimit && nFontWidth > MIX_FONT_PIXEL_SIZE)        //最大字体
    {
        nFontWidth = MIX_FONT_PIXEL_SIZE;
    }

    if (nFontWidth < nHeight)
    {
        nPixelSize = nFontWidth;
    }
    else
    {
        nPixelSize = nHeight;
    }
    return true;
}

void ResetFontAgain(QWidget* pWidget, const int nSize, bool bIsIgnoreLimit)
{
    if (nullptr == pWidget || nSize <= 0)
    {
        return ;
    }

    int nPixelSize = 0;
    bool nRet = ReviseTextPointSizeByWidgetSize(pWidget->width(), pWidget->height(), nSize, nPixelSize, bIsIgnoreLimit);
    if (nRet)
    {
        QFont font = pWidget->font();
        font.setPixelSize(nPixelSize);
        pWidget->setFont(font);
    }
}

void ResultWidget::SetMeasureTarget(QString strTarget)
{
    m_targetLabel->setText(strTarget);
}

void ResultWidget::SetMeasureResult(QString strResult)
{
//    QFont typeTestFont = m_resultLabel->font();
//    int point = GetPointSize(strResult, RESULT_WIDTH-40);
//    typeTestFont.setPointSize(point);
//    typeTestFont.setWeight(80);

//    m_resultLabel->setFont(typeTestFont);
    m_resultLabel->setText(strResult);
}

void ResultWidget::SetMeasureTime(QString strDateTime)
{
    QString strDate = "";
    QString strTime = "";

    DateTimeStringAnalysis(strDateTime, strDate, strTime);
    m_dateLabel->setText(strDate);
//    m_timeLabel->setText(strTime);
}

void ResultWidget::DateTimeStringAnalysis(QString &dateTime, QString &date, QString &time)
{
    QStringList strList = dateTime.split(QRegExp("[ ]"));

    if (strList.size() == 2)
    {
        date = strList.at(0);
        time = strList.at(1);
    }
}


int ResultWidget::GetPointSize(QString& text, int limitWidth)
{
    QFont font = m_resultLabel->font();
    font.setPointSize(RESULT_MAX_SIZE);
    int size = RESULT_MAX_SIZE;

    QFontMetrics fontWidth(font);
    int textWidth = fontWidth.width(text);

    while(size > 20 && textWidth > limitWidth)
    {
        size = size - 1;
        font.setPointSize(size);

        QFontMetrics fontWidth(font);
        textWidth = fontWidth.width(text);
    }

    if (size > RESULT_MAX_SIZE)
    {
        size = RESULT_MAX_SIZE;
    }
    return size;
}

void ResultWidget::SetMeasureResultFont(int fontSize)
{
    if(fontSize > 0)
    {
        QFont measureResultFont = m_resultLabel->font();
        measureResultFont.setPointSize(fontSize);
        m_resultLabel->setFont(measureResultFont);
    }
    QString result = m_resultLabel->text();
    if(result.length() > 6)
    {
//       ResetFontAgain(m_resultLabel, 4, false);
        QFont font = m_resultLabel->font();
        font.setPixelSize(45 - (result.length()-6)*5);
        m_resultLabel->setFont(font);
    }
    else
    {
        ResetFontAgain(m_resultLabel, 3, false);
    }
}

}

