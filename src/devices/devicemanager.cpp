#include "devicemanager.h"

namespace device
{

ConnectionPtr DeviceManager::Active() const
{
	for (const auto& [number, connection] : _data)
	{
		if (connection->IsActive())
			return connection;
	}

	return nullptr;
}

void DeviceManager::SetActive(int number)
{
	for (const auto& [number, connection] : _data)
		connection->_active = false;

	ConnectionPtr connection = FindByNumber(number);
	if (connection != nullptr)
		connection->_active = true;
}

void DeviceManager::Add(const device::DevicePtr &device)
{
	static int number = 0;
	ConnectionPtr connection = Connection::Make(device);
	connection->_number = ++number;
	connection->_active = true;

	for (const auto& [number, connection] : _data)
		connection->_active = false;

	_data.emplace(number, connection);
}

void DeviceManager::Remove(const device::DevicePtr &device)
{
	for (auto it = _data.begin(); it != _data.end();)
	{
		if (it->second->GetDevice() == device)
			it = _data.erase(it);
		else
			++it;
	}
}

void DeviceManager::Remove(int number)
{
	_data.erase(number);
}

void DeviceManager::RemoveActive()
{
	Remove(Active()->Number());
}

void DeviceManager::RemoveAll()
{
	for (const auto& [number, connection] : _data)
		connection->Stop();
	_data.clear();
}

ConnectionPtr DeviceManager::FindByNumber(int number) const
{
	auto it = _data.find(number);
	if (it != _data.end())
		return it->second;
	return nullptr;
}

device::DevicePtr DeviceManager::FindDeviceByNumber(int number) const
{
	ConnectionPtr connection = FindByNumber(number);
	if (connection != nullptr)
		return connection->GetDevice();
	return nullptr;
}

}
