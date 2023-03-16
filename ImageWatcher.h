#pragma once

#include <QFileSystemWatcher>
#include <QUrl>
#include <QFile>
#include <qqml.h>

#ifdef Q_OS_WIN
#include <windows.h>
#endif

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

		bool exclusive = true;
#ifdef Q_OS_WIN
		auto h = CreateFileW(
			(LPCWSTR)path.utf16(),
			GENERIC_READ,
			0,
			NULL,
			OPEN_EXISTING,
			FILE_ATTRIBUTE_NORMAL,
			NULL
		);
		if (h == INVALID_HANDLE_VALUE)
			exclusive = false;
		else
			CloseHandle(h);
#endif
		if (exclusive)
			emit imageChanged(QUrl::fromLocalFile(path));
	}

private:
	QUrl mImageUrl;
};
