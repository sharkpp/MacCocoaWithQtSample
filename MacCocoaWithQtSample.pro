#-------------------------------------------------
#
# Project created by QtCreator 2016-12-10T14:01:19
#
#-------------------------------------------------

QT       += core gui

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

TARGET = MacCocoaWithQtSample
TEMPLATE = app


SOURCES += main.cpp\
        mainwindow.cpp

HEADERS  += mainwindow.h \
    cocoabutton.h

FORMS    += mainwindow.ui

OBJECTIVE_SOURCES += \
    cocoabutton.mm

macx: LIBS += -framework AppKit
