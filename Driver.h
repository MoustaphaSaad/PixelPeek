#pragma once

#include <QObject>
#include <QString>
#include <qqml.h>

#include "BuildInfo.h"
#include "ImageWatcher.h"

class Driver: public QObject
{
	Q_OBJECT
	Q_PROPERTY(QString version READ version CONSTANT)
	Q_PROPERTY(ImageWatcher* watcher READ watcher CONSTANT)
	QML_ELEMENT
	QML_SINGLETON
public:
	Driver(QObject* parent = nullptr)
		: QObject(parent)
	{
		mWatcher = new ImageWatcher{this};
	}

	QString version() const { return VERSION; }
	ImageWatcher* watcher() const { return mWatcher; }
private:
	ImageWatcher* mWatcher = nullptr;
};
