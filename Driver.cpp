#include "Driver.h"

#include <QQmlEngine>

Driver::Driver(QObject* parent)
	: QObject(parent)
{
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
	if (mHistory.size() > index)
		return mHistory[index];
	else
		return QImage{};
}

void Driver::handleImageChanged(const QUrl& imageUrl)
{
	QImage img;
	if (img.load(imageUrl.toLocalFile()) == false)
		qWarning() << "failed to load image" << imageUrl;
	mHistory.push_back(img);
	emit historyImageCountChanged(historyImageCount());
	emit reloadImage();
}

void Driver::handleImageUrlChanged(const QUrl& imageUrl)
{
	mHistory.clear();
	handleImageChanged(imageUrl);
}