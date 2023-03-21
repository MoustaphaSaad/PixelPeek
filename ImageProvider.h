#pragma once

#include <QQuickImageProvider>
#include <QImage>

class Driver;

class ImageProvider: public QQuickImageProvider
{
public:
	ImageProvider(Driver* driver);

	QImage requestImage(const QString &id, QSize *size, const QSize &requestedSize) override;
private:
	Driver* mDriver = nullptr;
};
