#pragma once

#include <QObject>
#include <QImage>
#include <QDateTime>
#include <qqml.h>

class HistoryImage: public QObject
{
	Q_OBJECT
	Q_PROPERTY(QImage image READ image WRITE setImage NOTIFY imageChanged)
	Q_PROPERTY(QDateTime timestamp READ timestamp WRITE setTimestamp NOTIFY timestampChanged)
	QML_ELEMENT
public:
	HistoryImage(QObject* parent = nullptr)
		: QObject(parent)
	{}

	QImage image() const { return mImage; }
	void setImage(const QImage& value)
	{
		mImage = value;
		emit imageChanged(mImage);
	}

	QDateTime timestamp() const { return mTimestamp; }
	void setTimestamp(const QDateTime& value)
	{
		if (value == mTimestamp)
			return;
		mTimestamp = value;
		emit timestampChanged(mTimestamp);
	}

signals:
	void imageChanged(const QImage& image);
	void timestampChanged(const QDateTime& timestamp);

private:
	QImage mImage;
	QDateTime mTimestamp;
};
