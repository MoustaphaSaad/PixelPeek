#pragma once

#include <QObject>
#include <QString>
#include <QVector>
#include <QImage>
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
	static Driver* singleton();
	static Driver* create(QQmlEngine *qmlEngine, QJSEngine *jsEngine);

	QString version() const { return VERSION; }
	ImageWatcher* watcher() const { return mWatcher; }

	QImage latestImage() const;
signals:
	void reloadImage();

private slots:
	void handleImageChanged(const QUrl& imageUrl);
	void handleImageUrlChanged(const QUrl& imageUrl);

private:
	Driver(QObject* parent = nullptr);

	ImageWatcher* mWatcher = nullptr;
	QVector<QImage> mHistory;
};
