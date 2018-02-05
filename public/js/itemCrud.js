// check for connection
// console.log('connected')
// $('body').append($('<p>jquery</p>'))

const deleteItem = (itemId) => {
	console.log("you deleted: " + itemId);
	$.ajax({
		url: '/items/j/' + itemId,
		method: 'DELETE',
		dataType: 'JSON',
		success: getItems,
		fail: (err) => {
			console.log(err, 'there was an error in delete')
		}

	})
}

const editItem = (itemId) => {
	console.log("you edited: " + itemId);

	const title = $('#new-item').val();

	$.ajax({
		url: 'items/j/' + itemId,
		method: 'PATCH',
		dataType: 'JSON',
		data: {
			title: title
		},
		success: getItems,
		fail: (err) => {
			console.log(err, 'there was an error with the edit ajax call')
		}
	})
}


$('#items').on('click', 'li', (event) => {
	// getting the item #
	const itemId = $(event.currentTarget).data('thisitem');
	// getting the route for the action
	const action = $(event.target).data('action');

	if (action == "delete") deleteItem(itemId);
	if (action == "edit") editItem(itemId);
})

// this is creating a new item with the information submitted in the form 
$('#add-item').on('click', (event) => {

	const title = $('#new-item').val();

	$.ajax({
		url: '/items/j',
		method: 'POST',
		dataType: 'JSON',
		data: {
			title: title
		},
		success: (data) => {
			console.log(data)
			$('#new-item').val("");
			getItems();
		},
		fail: (err) => {
			console.log(err, "post is broke")
		}
	})
})

const getItems = () => {
	$.ajax({
	url: '/items/j',
	method: 'GET',
	dataType: 'JSON',
	success: printResults,
	fail: (err) => {
		console.log(err, 'index/get is broke')
	}
})
}

const printResults = (data) => {
	$('#items').empty()
	// console.log(data)
	const theItems = data.items;
	data.items.forEach((item) => {
		const $item = $('<li data-thisitem="' + item.id + '">');
		$item.text(item.title);
		$item.append($('<button data-action="delete">Delete</button>'));
		$item.append($('<a href="#" data-action="edit">Edit</a>'));
		$('#items').append($item);
	});
}

getItems()

