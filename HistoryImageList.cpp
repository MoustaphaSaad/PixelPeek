#include "HistoryImageList.h"
#include "HistoryImage.h"

HistoryImageList::HistoryImageList(QObject* parent)
	: QAbstractListModel(parent)
{}

int HistoryImageList::rowCount(const QModelIndex& parent) const
{
	return mImages.size();
}

QVariant HistoryImageList::data(const QModelIndex& index, int role) const
{
	auto row = index.row();
	switch (role)
	{
	case Qt::DisplayRole:
		return QVariant::fromValue(mImages[row]);
	case NameRole:
		return QString("Image #%1").arg(row);
	case TimestampRole:
		return mImages[row]->timestamp();
	default:
		qFatal("unknown history image role");
		return QVariant{};
	}
}

QHash<int, QByteArray> HistoryImageList::roleNames() const
{
	QHash<int, QByteArray> names;
	names[NameRole] = "name";
	names[TimestampRole] = "timestamp";
	return names;
}

void HistoryImageList::addImage(HistoryImage* image)
{
	beginInsertRows(QModelIndex{}, mImages.size(), mImages.size());
	mImages.push_back(image);
	endInsertRows();
}

void HistoryImageList::clearImages()
{
	beginResetModel();
	mImages.clear();
	endResetModel();
}
