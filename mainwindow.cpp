#include "mainwindow.h"
#include "ui_mainwindow.h"
#include <QMessageBox>

MainWindow::MainWindow(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::MainWindow)
{
    ui->setupUi(this);

    connect(ui->buttonQt,    SIGNAL(clicked()), this, SLOT(onQtButtonClick()));
    connect(ui->buttonCocoa, SIGNAL(clicked()), this, SLOT(onCocoaButtonClick()));
}

MainWindow::~MainWindow()
{
    delete ui;
}

void MainWindow::onQtButtonClick()
{
    QMessageBox msgBox;
    msgBox.setText("Qt Button clicked!");
    msgBox.exec();
}

void MainWindow::onCocoaButtonClick()
{
    QMessageBox msgBox;
    msgBox.setText("Cocoa Button clicked!");
    msgBox.exec();
}
