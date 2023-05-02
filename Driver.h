#pragma once

#include <QObject>
#include <QString>
#include <QVector>
#include <QImage>
#include <qqml.h>

#include "BuildInfo.h"
#include "ImageWatcher.h"
#include "HistoryImage.h"
#include "HistoryImageList.h"

class Driver: public QObject
{
	Q_OBJECT
	Q_PROPERTY(QString version READ version CONSTANT)
	Q_PROPERTY(ImageWatcher* watcher READ watcher CONSTANT)
	Q_PROPERTY(int historyImageCount READ historyImageCount NOTIFY historyImageCountChanged)
	Q_PROPERTY(HistoryImageList* historyImageList READ historyImageList CONSTANT)
	QML_ELEMENT
	QML_SINGLETON
public:
	static Driver* singleton();
	static Driver* create(QQmlEngine* qmlEngine, QJSEngine* jsEngine);

	QString version() const { return VERSION; }
	ImageWatcher* watcher() const { return mWatcher; }
	int historyImageCount() const { return mHistory.size(); }
	HistoryImageList* historyImageList() const { return mHistoryImageList; }

	QImage getImage(int index) const;
signals:
	void reloadImage();
	void historyImageCountChanged(int historyImageCount);

private slots:
	void handleImageChanged(const QUrl& imageUrl);
	void handleImageUrlChanged(const QUrl& imageUrl);

private:
	Driver(QObject* parent = nullptr);

	ImageWatcher* mWatcher = nullptr;

	HistoryImageList* mHistoryImageList = nullptr;
	QVector<HistoryImage*> mHistory;
};
