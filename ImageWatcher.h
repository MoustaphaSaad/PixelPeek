#pragma once

#include <QFileSystemWatcher>
#include <QUrl>
#include <QFile>
#include <qqml.h>

class ImageWatcher: public QFileSystemWatcher
{
	Q_OBJECT
	Q_PROPERTY(QUrl imageUrl READ imageUrl WRITE setImageUrl NOTIFY imageUrlChanged)
	QML_ELEMENT
public:
	ImageWatcher(QObject* parent = nullptr)
		: QFileSystemWatcher(parent)
	{
		connect(this, &ImageWatcher::fileChanged, this, &ImageWatcher::handleFileChanged);
	}

	QUrl imageUrl() const { return mImageUrl; }
	void setImageUrl(const QUrl& value)
	{
		if (mImageUrl == value)
			return;

		if (mImageUrl.isEmpty() == false)
			removePath(mImageUrl.toLocalFile());

		mImageUrl = value;
		emit imageUrlChanged(mImageUrl);

		if (mImageUrl.isEmpty() == false)
			addPath(mImageUrl.toLocalFile());
	}

signals:
	void imageUrlChanged(const QUrl& imageUrl);
	void imageChanged(const QUrl& imageUrl);

private slots:
	void handleFileChanged(const QString& path)
	{
		if (files().contains(path) == false)
			if (QFile::exists(path))
				addPath(path);
		emit imageChanged(QUrl::fromLocalFile(path));
	}

private:
	QUrl mImageUrl;
};
