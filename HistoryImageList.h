#pragma once

#include "HistoryImage.h"
#include <QAbstractListModel>
#include <QVector>
#include <qqml.h>

class HistoryImage;

class HistoryImageList: public QAbstractListModel
{
	Q_OBJECT
	Q_PROPERTY(int selectedImageIndex READ selectedImageIndex WRITE setSelectedImageIndex NOTIFY selectedImageIndexChanged)
	Q_PROPERTY(HistoryImage* selectedImage READ selectedImage NOTIFY selectedImageChanged)
	QML_ELEMENT
public:
	enum
	{
		NameRole = Qt::UserRole,
		TimestampRole,
	};

	HistoryImageList(QObject* parent = nullptr);

	int rowCount(const QModelIndex& parent = QModelIndex{}) const override;

	QVariant data(const QModelIndex& index, int role = Qt::DisplayRole) const override;

	QHash<int, QByteArray> roleNames() const override;

	void addImage(HistoryImage* image);

	void clearImages();

	int selectedImageIndex() const { return mSelectedImageIndex; }
	void setSelectedImageIndex(int value);
	HistoryImage* selectedImage() const
	{
		if (mSelectedImageIndex < mImages.size())
			return mImages[mSelectedImageIndex];
		else
			return nullptr;
	}

signals:
	void selectedImageIndexChanged(int selectedImageIndex);
	void selectedImageChanged(HistoryImage* selectedImage);

private:
	QVector<HistoryImage*> mImages;
	int mSelectedImageIndex = 0;
};
