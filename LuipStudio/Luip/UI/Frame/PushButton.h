/*
	最大化 最小化 关闭按钮
	作者：╰☆奋斗ing❤孩子`
	博客地址：http://blog.sina.com.cn/liang19890820
	QQ：550755606
	Qt分享、交流群：26197884

	注：请尊重原作者劳动成果，仅供学习使用，请勿盗用，违者必究！
*/

#ifndef SUI_FRAME_PUSHBUTTON_H
#define SUI_FRAME_PUSHBUTTON_H

#include <QPushButton>
#include <QPainter>
#include <QMouseEvent>

namespace UI
{
class PushButton : public QPushButton
{
	Q_OBJECT

public:

	explicit PushButton(QWidget *parent = 0);
	~PushButton();
    void setPicName(QString picName);

protected:

	void enterEvent(QEvent *);
	void leaveEvent(QEvent *);
	void mousePressEvent(QMouseEvent *event);
	void mouseReleaseEvent(QMouseEvent *event);
	void paintEvent(QPaintEvent *);

private:

	//枚举按钮的几种状态
	enum ButtonStatus{NORMAL, ENTER, PRESS, NOSTATUS};
	ButtonStatus status;
    QString picName;

    int btnWidth; //按钮宽度
    int btnHeight; //按钮高度
    bool mousePress; //按钮左键是否按下
};

}

#endif //SUI_FRAME_PUSHBUTTON_H

