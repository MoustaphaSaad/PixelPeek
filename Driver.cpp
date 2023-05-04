#include "Driver.h"

#include <QQmlEngine>

Driver::Driver(QObject* parent)
	: QObject(parent)
{
	mHistoryImageList = new HistoryImageList{this};
	connect(mHistoryImageList, &HistoryImageList::selectedImageIndexChanged, this, &Driver::reloadImage);

	mWatcher = new ImageWatcher{this};
	connect(mWatcher, &ImageWatcher::imageChanged, this, &Driver::handleImageChanged);
	connect(mWatcher, &ImageWatcher::imageUrlChanged, this, &Driver::handleImageUrlChanged);
}

Driver* Driver::singleton()
{
	static Driver mDriver;
	return &mDriver;
}

Driver* Driver::create(QQmlEngine*, QJSEngine*)
{
	auto res = singleton();
	QQmlEngine::setObjectOwnership(res, QQmlEngine::CppOwnership);
	return res;
}

QImage Driver::getImage(int index) const
{
	if (index < 0)
		return QImage{};

	if (mHistory.size() > index)
		return mHistory[index]->image();
	else
		return QImage{};
}

void Driver::handleImageChanged(const QUrl& imageUrl)
{
	QImage img;
	if (img.load(imageUrl.toLocalFile()) == false)
	{
		qWarning() << "failed to load image" << imageUrl;
		emit historyImageCountChanged(historyImageCount());
		emit reloadImage();
		return;
	}
	auto historyImage = new HistoryImage{this};
	historyImage->setImage(img);
	historyImage->setTimestamp(QDateTime::currentDateTime());
	mHistory.push_back(historyImage);
	mHistoryImageList->addImage(historyImage);
	mHistoryImageList->setSelectedImageIndex(mHistory.size() - 1);
	emit historyImageCountChanged(historyImageCount());
	emit reloadImage();
}

void Driver::handleImageUrlChanged(const QUrl& imageUrl)
{
	mHistory.clear();
	mHistoryImageList->clearImages();
	handleImageChanged(imageUrl);
}
