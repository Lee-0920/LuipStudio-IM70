/****************************************************************************
** Meta object code from reading C++ file 'NT66CalibrateCurveWidget.h'
**
** Created by: The Qt Meta Object Compiler version 67 (Qt 5.7.1)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../NT66CalibrateCurveWidget.h"
#include <QtCore/qbytearray.h>
#include <QtCore/qmetatype.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'NT66CalibrateCurveWidget.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 67
#error "This file was generated using the moc from 5.7.1. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
struct qt_meta_stringdata_ResultDetail__NT66CalibrateCurveWidget_t {
    QByteArrayData data[3];
    char stringdata0[46];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    qptrdiff(offsetof(qt_meta_stringdata_ResultDetail__NT66CalibrateCurveWidget_t, stringdata0) + ofs \
        - idx * sizeof(QByteArrayData)) \
    )
static const qt_meta_stringdata_ResultDetail__NT66CalibrateCurveWidget_t qt_meta_stringdata_ResultDetail__NT66CalibrateCurveWidget = {
    {
QT_MOC_LITERAL(0, 0, 38), // "ResultDetail::NT66CalibrateCu..."
QT_MOC_LITERAL(1, 39, 5), // "Close"
QT_MOC_LITERAL(2, 45, 0) // ""

    },
    "ResultDetail::NT66CalibrateCurveWidget\0"
    "Close\0"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_ResultDetail__NT66CalibrateCurveWidget[] = {

 // content:
       7,       // revision
       0,       // classname
       0,    0, // classinfo
       1,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       0,       // signalCount

 // slots: name, argc, parameters, tag, flags
       1,    0,   19,    2, 0x0a /* Public */,

 // slots: parameters
    QMetaType::Void,

       0        // eod
};

void ResultDetail::NT66CalibrateCurveWidget::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        NT66CalibrateCurveWidget *_t = static_cast<NT66CalibrateCurveWidget *>(_o);
        Q_UNUSED(_t)
        switch (_id) {
        case 0: _t->Close(); break;
        default: ;
        }
    }
    Q_UNUSED(_a);
}

const QMetaObject ResultDetail::NT66CalibrateCurveWidget::staticMetaObject = {
    { &CalibrateResultDetailWidget::staticMetaObject, qt_meta_stringdata_ResultDetail__NT66CalibrateCurveWidget.data,
      qt_meta_data_ResultDetail__NT66CalibrateCurveWidget,  qt_static_metacall, Q_NULLPTR, Q_NULLPTR}
};


const QMetaObject *ResultDetail::NT66CalibrateCurveWidget::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *ResultDetail::NT66CalibrateCurveWidget::qt_metacast(const char *_clname)
{
    if (!_clname) return Q_NULLPTR;
    if (!strcmp(_clname, qt_meta_stringdata_ResultDetail__NT66CalibrateCurveWidget.stringdata0))
        return static_cast<void*>(const_cast< NT66CalibrateCurveWidget*>(this));
    return CalibrateResultDetailWidget::qt_metacast(_clname);
}

int ResultDetail::NT66CalibrateCurveWidget::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = CalibrateResultDetailWidget::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 1)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 1;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 1)
            *reinterpret_cast<int*>(_a[0]) = -1;
        _id -= 1;
    }
    return _id;
}
QT_END_MOC_NAMESPACE
