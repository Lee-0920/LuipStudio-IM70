/****************************************************************************
** Meta object code from reading C++ file 'ReactController.h'
**
** Created by: The Qt Meta Object Compiler version 67 (Qt 5.7.1)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../ReactController.h"
#include <QtCore/qbytearray.h>
#include <QtCore/qmetatype.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'ReactController.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 67
#error "This file was generated using the moc from 5.7.1. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
struct qt_meta_stringdata_Controller__ReactController_t {
    QByteArrayData data[5];
    char stringdata0[70];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    qptrdiff(offsetof(qt_meta_stringdata_Controller__ReactController_t, stringdata0) + ofs \
        - idx * sizeof(QByteArrayData)) \
    )
static const qt_meta_stringdata_Controller__ReactController_t qt_meta_stringdata_Controller__ReactController = {
    {
QT_MOC_LITERAL(0, 0, 27), // "Controller::ReactController"
QT_MOC_LITERAL(1, 28, 18), // "EnvTempToLuaSignal"
QT_MOC_LITERAL(2, 47, 0), // ""
QT_MOC_LITERAL(3, 48, 4), // "temp"
QT_MOC_LITERAL(4, 53, 16) // "EnvTempToLuaSlot"

    },
    "Controller::ReactController\0"
    "EnvTempToLuaSignal\0\0temp\0EnvTempToLuaSlot"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_Controller__ReactController[] = {

 // content:
       7,       // revision
       0,       // classname
       0,    0, // classinfo
       2,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       1,       // signalCount

 // signals: name, argc, parameters, tag, flags
       1,    1,   24,    2, 0x06 /* Public */,

 // slots: name, argc, parameters, tag, flags
       4,    1,   27,    2, 0x0a /* Public */,

 // signals: parameters
    QMetaType::Void, QMetaType::Float,    3,

 // slots: parameters
    QMetaType::Void, QMetaType::Float,    3,

       0        // eod
};

void Controller::ReactController::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        ReactController *_t = static_cast<ReactController *>(_o);
        Q_UNUSED(_t)
        switch (_id) {
        case 0: _t->EnvTempToLuaSignal((*reinterpret_cast< float(*)>(_a[1]))); break;
        case 1: _t->EnvTempToLuaSlot((*reinterpret_cast< float(*)>(_a[1]))); break;
        default: ;
        }
    } else if (_c == QMetaObject::IndexOfMethod) {
        int *result = reinterpret_cast<int *>(_a[0]);
        void **func = reinterpret_cast<void **>(_a[1]);
        {
            typedef void (ReactController::*_t)(float );
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&ReactController::EnvTempToLuaSignal)) {
                *result = 0;
                return;
            }
        }
    }
}

const QMetaObject Controller::ReactController::staticMetaObject = {
    { &QObject::staticMetaObject, qt_meta_stringdata_Controller__ReactController.data,
      qt_meta_data_Controller__ReactController,  qt_static_metacall, Q_NULLPTR, Q_NULLPTR}
};


const QMetaObject *Controller::ReactController::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *Controller::ReactController::qt_metacast(const char *_clname)
{
    if (!_clname) return Q_NULLPTR;
    if (!strcmp(_clname, qt_meta_stringdata_Controller__ReactController.stringdata0))
        return static_cast<void*>(const_cast< ReactController*>(this));
    if (!strcmp(_clname, "BaseController"))
        return static_cast< BaseController*>(const_cast< ReactController*>(this));
    return QObject::qt_metacast(_clname);
}

int Controller::ReactController::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 2)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 2;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 2)
            *reinterpret_cast<int*>(_a[0]) = -1;
        _id -= 2;
    }
    return _id;
}

// SIGNAL 0
void Controller::ReactController::EnvTempToLuaSignal(float _t1)
{
    void *_a[] = { Q_NULLPTR, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 0, _a);
}
QT_END_MOC_NAMESPACE
