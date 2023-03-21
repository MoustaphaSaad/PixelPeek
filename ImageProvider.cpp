#include "ImageProvider.h"
#include "Driver.h"

ImageProvider::ImageProvider(Driver* driver)
	: QQuickImageProvider(QQuickImageProvider::Image),
	  mDriver(driver)
{}

QImage ImageProvider::requestImage(const QString &id, QSize *size, const QSize &requestedSize)
{
	auto res = mDriver->latestImage();

	if (size)
		*size = QSize(res.width(), res.height());

	if (requestedSize.width() > 0 && requestedSize.height() > 0)
		res = res.scaled(requestedSize, Qt::KeepAspectRatioByExpanding);
	return res;
}

