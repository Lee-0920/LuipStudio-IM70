/*
 设置阴影边框
 作者：╰☆奋斗ing❤孩子`
 博客地址：http://blog.sina.com.cn/liang19890820
 QQ：550755606
 Qt分享、交流群：26197884

 注：请尊重原作者劳动成果，仅供学习使用，请勿盗用，违者必究！
 */

#ifndef UI_FRAME_DROPSHADOWWIDGET_H
#define UI_FRAME_DROPSHADOWWIDGET_H

#include <QDialog>
#include <QWidget>
#include <QPainter>
#include <QMouseEvent>
#include <qmath.h>

namespace UI
{

class DropShadowWidget: public QDialog
{
Q_OBJECT


public:
    explicit DropShadowWidget(QWidget *parent = 0);
    ~DropShadowWidget();

protected:

    void mousePressEvent(QMouseEvent *event);
    void mouseReleaseEvent(QMouseEvent *event);
    void mouseMoveEvent(QMouseEvent *event);
    virtual void paintEvent(QPaintEvent *event);

private:

    QPoint m_movePoint; //移动的距离
    bool m_mousePress; //按下鼠标左键
};

}

#endif //UI_FRAME_DROPSHADOWWIDGET_H
