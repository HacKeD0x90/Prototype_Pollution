var qs = new URLSearchParams(location.search.slice(1));

// put it on the screen and use innerText to avoid XSS
document.body.appendChild(
  createElement({
    tag: "h2",
    innerText: `Search result for ${qs.get("q")}`,
  })
);

function createElement(config) {
  const element = document.createElement(config.tag);
  if (config.innerHTML) {
    element.innerHTML = config.innerHTML;
  } else {
    element.innerText = config.innerText;
  }
  return element;
}