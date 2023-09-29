#include "ImageProvider.h"
#include "Driver.h"

ImageProvider::ImageProvider(Driver* driver)
	: QQuickImageProvider(QQuickImageProvider::Image),
	  mDriver(driver)
{}

QImage ImageProvider::requestImage(const QString& id, QSize* size, const QSize& requestedSize)
{
	if (id == "magnify")
	{
		return mDriver->getMagnifyImage();
	}
	else
	{
		bool ok = false;
		int historyIndex = id.toInt(&ok);
		// get the latest image in case we fail to parse the id
		if (ok == false)
			historyIndex = mDriver->historyImageCount() - 1;

		auto res = mDriver->getImage(historyIndex);

		if (size)
			*size = QSize(res.width(), res.height());

		if (requestedSize.width() > 0 && requestedSize.height() > 0)
			res = res.scaled(requestedSize, Qt::KeepAspectRatioByExpanding);
		return res;
	}
}
