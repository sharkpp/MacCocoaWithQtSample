#include "cocoabutton.h"
#include <QWidget>
#include <QMoveEvent>
#include <QResizeEvent>

#import <Cocoa/Cocoa.h>

@interface CocoaButtonProxy: NSObject
{
    CocoaButtonWrapper *proxyDest;
}

- (id)init:(CocoaButtonWrapper*)object;
- (IBAction)clicked:(id)sender;

@end

@implementation CocoaButtonProxy

- (id)init:(CocoaButtonWrapper*)object
{
    self = [super init];
    proxyDest = object;
    return self;
}

- (IBAction)clicked:(id)sender
{
    proxyDest->handleClicked();
}

@end

CocoaButtonWrapper::CocoaButtonWrapper(QWidget *parent)
    : QMacCocoaViewContainer(0, parent)
{
    // http://doc.qt.io/qt-5/qmaccocoaviewcontainer.html#details

    // 多くのCocoaオブジェクトは一時的なオートリリースオブジェクトを作成するので、
    // それらをキャッチするプールを作成します。
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];

    // NSButtonを作成し、QCocoaViewContainerで設定します。
    m_refButton = [[NSButton alloc] init];
    setCocoaView(m_refButton);

    CocoaButtonProxy *proxy = [[CocoaButtonProxy alloc] init:this];
    [m_refButton setTarget:proxy];
    [m_refButton setAction:@selector(clicked:)];

    //[proxy release]

    // Clean up our pool as we no longer need it.
    [pool release];
}

void CocoaButtonWrapper::handleClicked()
{
    emit clicked();
}

CocoaButton::CocoaButton(QWidget *parent)
    : QPushButton(parent)
{
    m_wrpper = new CocoaButtonWrapper(parent);

    connect(m_wrpper, SIGNAL(clicked()), this, SLOT(click()));
}

void CocoaButton::click()
{
    emit clicked();
}

void CocoaButton::setText(const QString &text)
{
    QString text_ = text + "*";
    [m_wrpper->m_refButton setTitle: text_.toNSString()];
}

void CocoaButton::moveEvent(QMoveEvent *event)
{
    NSRect frame;
    frame = [m_wrpper->m_refButton frame];
    frame.origin.x = event->pos().x();
    frame.origin.y = event->pos().y();
    [m_wrpper->m_refButton setFrame:frame];
}

void CocoaButton::resizeEvent(QResizeEvent *event)
{
    NSRect frame;
    frame = [m_wrpper->m_refButton frame];
    frame.size.width = event->size().width();
    frame.size.height = event->size().height();
    [m_wrpper->m_refButton setFrame:frame];
}
