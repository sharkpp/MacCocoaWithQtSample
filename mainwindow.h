#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>

namespace Ui {
class MainWindow;
}

class MainWindow : public QMainWindow
{
    Q_OBJECT

public:
    explicit MainWindow(QWidget *parent = 0);
    ~MainWindow();

private:

    void paintEvent(QPaintEvent *) {}

public slots:
    void onQtButtonClick();
    void onCocoaButtonClick();

private:
    Ui::MainWindow *ui;
};

#endif // MAINWINDOW_H
