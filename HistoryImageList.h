#pragma once

#include <QAbstractListModel>
#include <QVector>
#include <qqml.h>

class HistoryImage;

class HistoryImageList: public QAbstractListModel
{
	Q_OBJECT
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

private:
	QVector<HistoryImage*> mImages;
};
