#ifndef COCOABUTTON_H
#define COCOABUTTON_H

#include <QMacCocoaViewContainer>
#include <QPushButton>

class QWidget;

// https://github.com/vasi/vdfuse/blob/master/include/VBox/VBoxCocoa.h

#ifdef __OBJC__
#define ADD_COCOA_NATIVE_REF(CocoaClass) \
@class CocoaClass; \
typedef CocoaClass *Native##CocoaClass##Ref; \
typedef const CocoaClass *ConstNative##CocoaClass##Ref
#else /* __OBJC__ */
#define ADD_COCOA_NATIVE_REF(CocoaClass) \
typedef void *Native##CocoaClass##Ref; \
typedef const void *ConstNative##CocoaClass##Ref
#endif /* __OBJC__ */

ADD_COCOA_NATIVE_REF(NSButton);

class CocoaButtonWrapper
        : public QMacCocoaViewContainer
{
    Q_OBJECT
public:
    explicit CocoaButtonWrapper(QWidget *parent = 0);

    void handleClicked();

signals:

    void clicked();

public slots:

public:
    NativeNSButtonRef m_refButton;
};

class CocoaButton
        : public QPushButton
{
    Q_OBJECT
public:
    explicit CocoaButton(QWidget *parent = 0);

    void setText(const QString &text);

    virtual void moveEvent(QMoveEvent *event);
    virtual void resizeEvent(QResizeEvent *event);

signals:

    void clicked();

public slots:

    void click();

private:
    CocoaButtonWrapper* m_wrpper;
};

#endif // COCOABUTTON_H
