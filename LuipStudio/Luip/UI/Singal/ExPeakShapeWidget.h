#ifndef EXPEAKSHAPEWIDGET_H
#define EXPEAKSHAPEWIDGET_H

#include <QWidget>
#include <QPushButton>
#include <qwt_plot_curve.h>
#include <qwt_plot.h>
#include <qwt_plot_grid.h>
#include <qwt_symbol.h>
#include <qwt_plot_canvas.h>
#include <qwt_plot_layout.h>
#include <qwt_legend.h>
#include <qwt_legend_label.h>
#include <qwt_scale_draw.h>
#include <qwt_plot.h>
#include <qwt_plot_curve.h>
#include <qwt_plot_picker.h>
#include <qwt_plot_panner.h>
#include <qwt_plot_magnifier.h>
#include <qwt_legend.h>
#include <qwt_plot_grid.h>
#include <qwt_picker_machine.h>
#include<qwt_plot.h>
#include <qwt_plot_layout.h>
#include <qwt_plot_canvas.h>
#include <qwt_plot_renderer.h>
#include <qwt_plot_grid.h>
#include <qwt_plot_histogram.h>
#include <qwt_plot_curve.h>
#include <qwt_plot_zoomer.h>
#include <qwt_plot_panner.h>
#include <qwt_plot_magnifier.h>
#include <qwt_legend.h>
#include <qwt_legend_label.h>
#include <qwt_column_symbol.h>
#include <qwt_series_data.h>
#include <qpen.h>
#include <qwt_symbol.h>
#include <qwt_picker_machine.h>
#include <QTableWidget>
#include <QMap>
#include <qwt_scale_draw.h>
#include <QDateTime>
#include "ResultManager/ResultManager.h"
#include "UI/UserChangeManager/IUserChangeNotifiable.h"
#include "PeakShapeWidget.h"
#define MAX_SIGNAL 5
#define PRECISE 0.001

using namespace Controller;

namespace UI
{

class ExPeakShape:
        public QWidget,
        public IUserChangeNotifiable
{
    Q_OBJECT
public:
    explicit ExPeakShape(QWidget *parent = 0);
    ~ExPeakShape();
    void OnUserChange();

private slots:
    void SlotUpdaterData();
    void SlotRangeChange();
    void SlotPeakhighChange(QString arg);
    void SlotAddTopY();
    void SlotSubstractTopY();
    void SlotAddBottomY();
    void SlotSubtractBottomY();

private:
    QwtPlot *plot;

    std::map<QString, PeakDataCategory>m_peakDataCategory;
    OOLUA::Script *m_lua;
    PeakDataCategory m_PeakCategory;

    void SetDisplayDays();
    void InitCanvas();
    double m_scanBuf[4096];
    double m_TscanBuf[2][2048];
    double m_realData[5];
    int m_scanDataLen;
    int m_newDataIndex;
    int m_range;
    int m_changeCount;
    float m_yTopValve;
    float m_yBottomValve;
    float m_yDisplayPeakHigh;
    bool m_Adaptive;
    QTimer *timer;
    QPushButton *m_adaptButton;
    TOCDriveController *m_toc;
};
}

#endif // PEAKSHAPEWIDGET_H
